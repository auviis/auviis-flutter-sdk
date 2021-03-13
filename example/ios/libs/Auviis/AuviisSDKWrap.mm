#import "AuviisSDKWrap.h"
#import "AppDelegate.h"

AuviisSDKWrap* AuviisSDKWrap::_server_handle = nullptr;

AuviisSDKWrap::AuviisSDKWrap(){
}
AuviisSDKWrap::~AuviisSDKWrap(){
}
AuviisSDKWrap* AuviisSDKWrap::getInstance(){
    if(_server_handle == nullptr){
        _server_handle = new AuviisSDKWrap();
    }
    return _server_handle;
}
void AuviisSDKWrap::setMethodChannel(FlutterMethodChannel *method_channel_){
    method_channel = method_channel_;
}
void AuviisSDKWrap::init(std::string app_id, std::string app_signature){
    //1. Setup Callback functions
    Auviis::setOnInitSuccessCallback(std::bind(&AuviisSDKWrap::onInitSuccess, this,std::placeholders::_1));
    
    Auviis::setOnActivatedCallback(std::bind(&AuviisSDKWrap::onActivated, this,std::placeholders::_1));
    
    Auviis::setOnErrorCallback(std::bind(&AuviisSDKWrap::onError, this,std::placeholders::_1,std::placeholders::_2));
    Auviis::setOnDisconnectCallback(std::bind(&AuviisSDKWrap::onDisconnect, this,std::placeholders::_1,std::placeholders::_2));
    
    Auviis::setOnJoinChannelCallback(std::bind(&AuviisSDKWrap::onJoinChannel, this,std::placeholders::_1,std::placeholders::_2, std::placeholders::_3, std::placeholders::_4));
    
    Auviis::setOnReceiveChannelMembersCallback(std::bind(&AuviisSDKWrap::onReceiveChannelMembers, this,std::placeholders::_1,std::placeholders::_2));
    
    Auviis::setOnTextChatReceiveCallback(std::bind(&AuviisSDKWrap::onTextMessage, this,std::placeholders::_1,std::placeholders::_2, std::placeholders::_3));
    
    Auviis::setOnVoiceMessageReady(std::bind(&AuviisSDKWrap::onVoiceMessageReady, this,std::placeholders::_1,std::placeholders::_2));
    
    Auviis::setOnVoiceChatReceiveCallback(std::bind(&AuviisSDKWrap::onVoiceMessage, this,std::placeholders::_1,std::placeholders::_2, std::placeholders::_3));
    //2. Setup app id and signature
    Auviis::init(app_id.c_str(), app_signature.c_str());
    //3. Connect server
}
void AuviisSDKWrap::connect(){
    Auviis::connect();
}
void AuviisSDKWrap::stop(){
    Auviis::stop();
}
void AuviisSDKWrap::outputToSpeaker(){
    Auviis::outputToSpeaker();
}
void AuviisSDKWrap::outputToDefault(){
    Auviis::outputToDefault();
}
void AuviisSDKWrap::unmuteSend(){
    Auviis::unmuteSend();
}
void AuviisSDKWrap::muteSend(){
    Auviis::muteSend();
}
void AuviisSDKWrap::joinChannel(int64_t channel_id){
    Auviis::joinChannel(channel_id);
}
void AuviisSDKWrap::setActiveVoiceChannel(int64_t channel_id){
    Auviis::setActiveVoiceChannel(channel_id);
}
void AuviisSDKWrap::sendVoiceChat(int64_t channel_id){
    Auviis::sendVoiceChat(channel_id);
}
void AuviisSDKWrap::recordVoice(){
    Auviis::recordVoice();
}
void AuviisSDKWrap::stopRecord(){
    Auviis::stopRecord();
}

//DELEGATE
void AuviisSDKWrap::onError(int code, std::string reason){
    printf("onSDKError\n");
    if(!method_channel) return;
    NSArray *args = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:code],[NSString stringWithUTF8String:reason.c_str()], nil];
    [method_channel invokeMethod:@"onSDKError" arguments:args];
}
void AuviisSDKWrap::onDisconnect(int code, std::string reason){
    std::cout << reason << std::endl;
}
#pragma --
#pragma SDKCALLBACK
void AuviisSDKWrap::onInitSuccess(int64_t peer_id){
    printf("onSDKInitSuccess\n");
    if(!method_channel) return;
    [method_channel invokeMethod:@"onSDKInitSuccess" arguments:[NSNumber numberWithLongLong:peer_id]];
}
void AuviisSDKWrap::onActivated(int64_t peer_id){
    printf("onSDKActivated with id:%lld\n",peer_id);
    if(!method_channel) return;
    [method_channel invokeMethod:@"onSDKActivated" arguments:[NSNumber numberWithLongLong:peer_id]];
}
void AuviisSDKWrap::onJoinChannel(int code, int64_t channel_id, int64_t member_count, std::string msg){
    printf("onSDKJoinChannel with id:%lld\n",channel_id);
    Auviis::setActiveVoiceChannel(channel_id);
    if(!method_channel) return;
    NSArray *args = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:code],
                                                     [NSNumber numberWithLongLong: channel_id],
                                                     [NSNumber numberWithLongLong: member_count],
                                                     [NSString stringWithUTF8String:msg.c_str()], nil];
    [method_channel invokeMethod:@"onSDKJoinChannel" arguments:args];
}

void AuviisSDKWrap::onReceiveChannelMembers(int64_t channel_id, std::vector<int64_t> peers){
    printf("onReceiveChannelMembers: having %lu online\n", Auviis::getChannelMembers(123).size());
    if(!method_channel) return;
    NSNumber* n_peers[peers.size()];
    for (int i =0; i < peers.size(); i++) {
        n_peers[i] = [NSNumber numberWithLongLong: peers[i]];
    }
    NSArray *ns_peers = [NSArray arrayWithObjects:&n_peers[0] count:peers.size()];
    NSArray *args = [[NSArray alloc] initWithObjects:[NSNumber numberWithLongLong: channel_id],ns_peers, nil];
    [method_channel invokeMethod:@"onReceiveChannelMembers" arguments:args];
}
void AuviisSDKWrap::onTextMessage(int64_t sender_id, int64_t channel_id, std::string msg){
    printf("onSDKTextMessage: having %lu online\n", Auviis::getChannelMembers(123).size());
    if(!method_channel) return;
    NSArray *args = [[NSArray alloc] initWithObjects:[NSNumber numberWithLongLong: sender_id],
                                                     [NSNumber numberWithLongLong: channel_id],
                                                     [NSString stringWithUTF8String:msg.c_str()], nil];
    [method_channel invokeMethod:@"onSDKTextMessage" arguments:args];
}
void AuviisSDKWrap::onVoiceMessage(int64_t sender_id, int64_t channel_id, std::string msg_id){
    printf("onSDKVoiceMessage: having %lu online\n", Auviis::getChannelMembers(123).size());
    if(!method_channel) return;
    NSArray *args = [[NSArray alloc] initWithObjects:[NSNumber numberWithLongLong: sender_id],
                                                     [NSNumber numberWithLongLong: channel_id],
                                                     [NSString stringWithUTF8String:msg_id.c_str()], nil];
    [method_channel invokeMethod:@"onSDKVoiceMessage" arguments:args];
}
void AuviisSDKWrap::onVoiceMessageReady(int code, long record_id){
    printf("onSDKVoiceMessageReady: having %lu online\n", Auviis::getChannelMembers(123).size());
    if(!method_channel) return;
    NSArray *args = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:code],
                                                     [NSNumber numberWithLongLong: record_id],nil];
    [method_channel invokeMethod:@"onSDKVoiceMessageReady" arguments:args];
}
