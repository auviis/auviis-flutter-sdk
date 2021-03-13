#ifndef SDKDelegate_h
#define SDKDelegate_h
#include <iostream>
#include <string>
#include <vector>
#import <Auviis/auviis.hpp>
#import <UIKit/UIKit.h>
#import <Flutter/Flutter.h>

class AuviisSDKWrap{
public:
    AuviisSDKWrap();
    ~AuviisSDKWrap();
public:
    static AuviisSDKWrap *getInstance();
public:
    void init(std::string app_id, std::string app_signature);
    void connect();
    void stop();
    void outputToSpeaker();
    void outputToDefault();
    void unmuteSend();
    void muteSend();
    void joinChannel(int64_t channel_id);
    void setActiveVoiceChannel(int64_t channel_id);
    void sendVoiceChat(int64_t channel_id);
    void recordVoice();
    void stopRecord();
    void onInitSuccess(int64_t peer_id);
    void onActivated(int64_t peer_id);
    void onError(int code, std::string reason);
    void onDisconnect(int code, std::string reason);
    void onJoinChannel(int code, int64_t channel_id, int64_t member_count, std::string msg);
    void onReceiveChannelMembers(int64_t channel_id, std::vector<int64_t> peers);
    void onTextMessage(int64_t sender_id, int64_t channel_id, std::string msg);
    void onVoiceMessage(int64_t sender_id, int64_t channel_id, std::string msg_id);
    void onVoiceMessageReady(int code, long record_id);
public:
    void setMethodChannel(FlutterMethodChannel *method_channel_);
protected:
    static AuviisSDKWrap *_server_handle;
private:
    FlutterMethodChannel *method_channel = nullptr;
};


#endif /* SDKDelegate_h */
