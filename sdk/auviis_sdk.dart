import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
const MethodChannel auviisMethodChannel =  MethodChannel('com.auviis.sdk');

ValueChanged<MethodCall> auviis_Callback = null;

void Auviis_startSDK(String app_id, String app_signature){
  auviisMethodChannel.setMethodCallHandler(auviisCallbackHandler);

  auviisMethodChannel.invokeMethod('Auviis_startSDK', [app_id, app_signature]);

}
void Auviis_stopSDK(){
  auviisMethodChannel.invokeMethod('Auviis_stopSDK');
}
void Auviis_speakerOut(){
  auviisMethodChannel.invokeMethod('Auviis_speakerOut');
}
void Auviis_micOut(){
  auviisMethodChannel.invokeMethod('Auviis_micOut');
}
void Auviis_unmuteSend(){
  auviisMethodChannel.invokeMethod('Auviis_unmuteSend');
}
void Auviis_muteSend(){
  auviisMethodChannel.invokeMethod('Auviis_muteSend');
}
void Auviis_joinChannel(int channel_id){
  auviisMethodChannel.invokeMethod('Auviis_joinChannel', channel_id.toString());
}
void Auviis_setActiveVoiceChannel(int channel_id){
  auviisMethodChannel.invokeMethod('Auviis_setActiveVoiceChannel', channel_id.toString());
}
void Auviis_sendVoiceChat(int active_channel_id){
  auviisMethodChannel.invokeMethod('Auviis_sendVoiceChat', active_channel_id.toString());
}
void Auviis_recordVoice(){
  auviisMethodChannel.invokeMethod('Auviis_recordVoice');
}
void Auviis_stopRecord(){
  auviisMethodChannel.invokeMethod('Auviis_stopRecord');
}

void Auviis_setCallback(ValueChanged<MethodCall> callback){
  auviis_Callback = callback;
}
Future<dynamic>  auviisCallbackHandler(MethodCall methodCall) async {
  debugPrint('sending callbackHandler method, please use it as method detection in callback: ' + methodCall.method);
  if (auviis_Callback !=null){
    auviis_Callback(methodCall);
  }
}