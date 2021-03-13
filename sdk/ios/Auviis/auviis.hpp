//
//  auviis.hpp
//  Auviis
//
//  Created on 2/24/21.
//  Copyright © 2021. All rights reserved.
//

#ifndef auviis_hpp
#define auviis_hpp

#include <iostream>
#include <string>
#include <vector>
#ifdef __cplusplus
extern "C" {
#endif
    /*
     After connected to server successfully, the application will be assigned an unique identify, used to communicate to server.
     It can be seen as unique member of the session, and will be changed each time of connection.
     */
    int64_t Auviis_getUniqueId();
    /*
     If you want to create a new room, to can use this API to get a new voice channel, and then tell other room members to join to (you are also).
     */
    int64_t Auviis_createRandomChannel();
    /*
    Only one voice chat channel is avaiable at one time. Use this function to switch between active voice channel.
     */
    void Auviis_setActiveVoiceChannel(int64_t channel_id);
    /*
     Auviis is not only send voice stream but also send text message
     */
    void Auviis_sendTextChat(int64_t channel_id, const char *msg);
    /*
     Please not use with this release
     */
    void Auviis_recordVoice();
    /*
     Please not use with this release
     */
    void Auviis_playRecord();
    /*
     Please not use with this release
     */
    void Auviis_stopRecord();
    /*
     Please not use with this release
     */
    void Auviis_sendVoiceChat(int64_t channel_id);
    /*
     Please not use with this release
     */
    const char* Auviis_getRecordId();
    /*
     Please not use with this release
     */
    void Auviis_playVoiceMessage(const char* msg_id);
    /*
     Setup application id and signature, it is provided when user register an application
     */
    void Auviis_init(const char * id, const char * signature);
    /*
     Start the connection session to community server
     */
    void Auviis_default_connect();
    /*
     Start the connection session to dedicated server. Only use for enterprise users.
     */
    void Auviis_connect(const char* server_address,uint32_t port, bool ssl = false);
    /*
     Close the session
     */
    void Auviis_disconnect();
    /*
     Stop send/receive any data to/from server
     */
    void Auviis_stop();
    /*
     Check the session is ready
     */
    bool Auviis_ready();
    /*
     Join to a channel before can send any voice/text stream
     */
    void Auviis_joinChannel(int64_t channel_id);
    /*
     Leave a channel
     */
    void Auviis_leaveChannel(int64_t channel_id);
    /**
      Channel members
     */
//    int64_t* Auviis_getChannelMembers(int64_t channel_id);
    /*
     Send text chat to active channel
     */
//    void Auviis_sendTextChat(const char* text);
    /*
     Start to send and receive voice stream. The audio stream is only enable after use this function.
     */
    void Auviis_startVoiceStream();
    /*
     Stop send/receive any voice stream.
     */
    void Auviis_stopVoiceStream();
    /*
     Check if voice stream is enable
     */
    bool Auviis_isVoiceStreamEnable();
    /*
     Stop send voice stream, but can receive from others
     */
    void Auviis_muteSend();
    /*
     Start to send voice stream if it is currently stopped.
     */
    void Auviis_unmuteSend();
    /*
     Set output to  headset
     */
    void Auviis_outputToDefault();
    /*
     Set output to speaker
     */
    void Auviis_outputToSpeaker();
    /*
     Set output to bluetooth device, maybe it is not work at this release.
     */
    void Auviis_outputToBluetooth();
    //Audio
    /*
     Check if the inout and output audio devices are already initialized.
     */
    bool Auviis_audioReady();
    /*
     This feature does not work in this release.
     */
//    void Auviis_setLocalLoop(bool loop);
    /*
     Enable the input and output audio devices
     */
    void Auviis_enableAudio();
    /*
     Disable the input and output audio devices
     */
    void Auviis_disableAudio();


#ifdef __cplusplus
}
#endif

namespace Auviis {
    /*
     After connected to server successfully, the application will be assigned an unique identify, used to communicate to server.
     It can be seen as unique member of the session, and will be changed each time of connection.
     */
    int64_t getUniqueId();
    /*
     If you want to create a new room, to can use this API to get a new voice channel, and then tell other room members to join to (you are also).
     */
    int64_t createRandomChannel();
    /*
    Only one voice chat channel is avaiable at one time. Use this function to switch between active voice channel.
     */
    void setActiveVoiceChannel(int64_t channel_id);
    /*
     Auviis is not only send voice stream but also send text message
     */
    void sendTextChat(int64_t channel_id, std::string msg);
    /*
     Please not use with this release
     */
    void recordVoice();
    /*
     Please not use with this release
     */
    void playRecord();
    /*
     Please not use with this release
     */
    void stopRecord();
    /*
     Please not use with this release
     */
    void sendVoiceChat(int64_t channel_id);
    /*
     Please not use with this release
     */
    std::string getRecordId();
    /*
     Please not use with this release
     */
    void playVoiceMessage(std::string msg_id);
    /*
     Setup application id and signature, it is provided when user register an application
     */
    void init(const char * id, const char * signature);
    /*
     Start the connection session to community server
     */
    void connect();
    /*
     Start the connection session to dedicated server. Only use for enterprise users.
     */
    void connect(std::string server_address,uint32_t port, bool ssl = false);
    /*
     Close the session
     */
    void disconnect();
    /*
     Stop send/receive any data to/from server
     */
    void stop();
    /*
     Check the session is ready
     */
    bool ready();
    /*
     Join to a channel before can send any voice/text stream
     */
    void joinChannel(int64_t channel_id);
    /*
     Leave a channel
     */
    void leaveChannel(int64_t channel_id);
    /**
      Channel members
     */
    std::vector<int64_t> getChannelMembers(int64_t channel_id);
    /*
     Send text chat to active channel
     */
    void sendTextChat(std::string text);
    /*
     Start to send and receive voice stream. The audio stream is only enable after use this function.
     */
    void startVoiceStream();
    /*
     Stop send/receive any voice stream.
     */
    void stopVoiceStream();
    /*
     Check if voice stream is enable
     */
    bool isVoiceStreamEnable();
    /*
     Stop send voice stream, but can receive from others
     */
    void muteSend();
    /*
     Start to send voice stream if it is currently stopped.
     */
    void unmuteSend();
    /*
     Set output to  headset
     */
    void outputToDefault();
    /*
     Set output to speaker
     */
    void outputToSpeaker();
    /*
     Set output to bluetooth device, maybe it is not work at this release.
     */
    void outputToBluetooth();
//Audio
    /*
     Check if the inout and output audio devices are already initialized.
     */
    bool audioReady();
    /*
     This feature does not work in this release.
     */
    void setLocalLoop(bool loop);
    /*
     Enable the input and output audio devices
     */
    void enableAudio();
    /*
     Disable the input and output audio devices
     */
    void disableAudio();

    void setOnErrorCallback(std::function<void(int, std::string)>  onErrorCallback);
    //
    void setOnInitSuccessCallback(std::function<void(int64_t)>  onErrorCallback);
    //
    void setOnJoinChannelCallback(std::function<void(int, int64_t, int64_t, std::string)>  onJoinChannelCallback);
    //
    void setOnReceiveChannelMembersCallback(std::function<void(int64_t, std::vector<int64_t>)> onReceiveChannelMembersCallback);
    //
    void setOnReleaseChannelCallback(std::function<void(int64_t, int64_t)>  onReleaseChannelCallback);
    //
    void setOnTextChatReceiveCallback(std::function<void(int64_t, int64_t, std::string)>  onTextChatReceiveCallback);
    //
    void setOnVoiceChatReceiveCallback(std::function<void(int64_t, int64_t, std::string)>  onVoiceChatReceiveCallback);
    //
    void setOnDisconnectCallback(std::function<void(int, std::string)>  onDisconnectCallback);
    //
    void setOnActivatedCallback(std::function<void(int64_t)>  onActivatedCallback);
    //
    void setOnVoiceMessageReady(std::function<void(int, long)> onRecordVoiceSuccessCallback);
    //
    void setOnRecordVoiceError(std::function<void(int,std::string )> onRecordVoiceErrorCallback);
}

#endif /* auviis_hpp */
