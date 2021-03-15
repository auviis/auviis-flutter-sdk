package com.auviis.example;

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

import android.os.Bundle;
import android.util.Log;

import com.auviis.sdk.*;

import java.util.ArrayList;
import java.util.List;

public class MainActivity extends FlutterActivity implements AuviisDelegate{
    private static final String CHANNEL = "com.auviis.sdk";
    private boolean audioPermission = false;
    private long active_channel_id = 0;
    private MethodChannel m_MethodChannel = null;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //
        AuviisClass.getInstance().setDelegate(this);
        AuviisClass.loadLibrary(this);
        //checking if you have the permission
        AuviisClass.getInstance().requestAudioPermission();
    }
    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        m_MethodChannel = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL);
        m_MethodChannel.setMethodCallHandler(
                        (call, result) -> {
                            // Note: this method is invoked on the main thread.
                            // TODO
                            Log.i("SDK","Receive call from flutter: " + call.method);
                            if (call.method.equals("Auviis_startSDK")) {
                                List<String> values = (List<String>) call.arguments;
                                AuviisClass.init(this,values.get(0),values.get(1));
                                AuviisClass.getInstance().connect();
                                result.success(null);
                            }
                            else if (call.method.equals("Auviis_stopSDK")) {
                                AuviisClass.getInstance().stop();
                                result.success(null);
                            }
                            else if (call.method.equals("Auviis_speakerOut")) {
                                AuviisClass.getInstance().outputToSpeaker();
                                result.success(null);
                            }
                            else if (call.method.equals("Auviis_micOut")) {
                                AuviisClass.getInstance().outputToDefault();
                                result.success(null);
                            }
                            else if (call.method.equals("Auviis_unmuteSend")) {
                                AuviisClass.getInstance().unmuteSend();
                                result.success(null);
                            }
                            else if (call.method.equals("Auviis_muteSend")) {
                                AuviisClass.getInstance().muteSend();
                                result.success(null);
                            }
                            else if (call.method.equals("Auviis_joinChannel")) {
                                long channel_id =  Long.parseLong((String)call.arguments);
                                AuviisClass.getInstance().joinChannel(channel_id);
                                result.success(null);
                            }
                            else if (call.method.equals("Auviis_setActiveVoiceChannel")) {
                                long channel_id = Long.parseLong((String)call.arguments);
                                active_channel_id = channel_id;
                                AuviisClass.getInstance().setActiveVoiceChannel(channel_id);
                                result.success(null);
                            }
                            else if (call.method.equals("Auviis_sendVoiceChat")) {
                                long channel_id = Long.parseLong((String)call.arguments);
                                AuviisClass.getInstance().sendVoiceChat(active_channel_id);
                                result.success(null);
                            }
                            else if (call.method.equals("Auviis_recordVoice")) {
                                AuviisClass.getInstance().recordVoice();
                                result.success(null);
                            }
                            else if (call.method.equals("Auviis_stopRecord")) {
                                AuviisClass.getInstance().stopRecord();
                                result.success(null);
                            }
                            else {
                                result.notImplemented();
                            }
                        }
                );
    }
    @Override
    public void onEnableAudioPermission(){
        audioPermission = true;
        m_MethodChannel.invokeMethod("onEnableAudioPermission", audioPermission);
    }

    @Override
    public void onDisableAudioPermission(){
        runOnUiThread(new Runnable() {
            @Override
            public void run() {
                m_MethodChannel.invokeMethod("onDisableAudioPermission",null);
            }
        });

    }
    @Override
    public void onSDKInitSuccess(long peer_id) {
        Log.i("AuviisSDK","AuviisSDK init successfully");

        runOnUiThread(new Runnable() {
            @Override
            public void run() {
                m_MethodChannel.invokeMethod("onSDKInitSuccess", peer_id);
//                TextView txtChatContent = (TextView)findViewById(R.id.txtChatContent);
//                txtChatContent.setText("AuviisSDK init successfully");
            }
        });
    }

    @Override
    public void onSDKActivated(long peer_id) {
        Log.i("AuviisSDK","AuviisSDK has assigned your peer id of " + peer_id);
//        AuviisClass.getInstance().joinChannel(123);
        runOnUiThread(new Runnable() {
            @Override
            public void run() {
                m_MethodChannel.invokeMethod("onSDKActivated", peer_id);
            }
        });
    }

    @Override
    public void onSDKError(int code, String reason) {
        Log.i("AuviisSDK","onSDKError");
        ArrayList<Object> args = new ArrayList<>(2);
        args.add(code);
        args.add(reason);
        runOnUiThread(new Runnable() {
            @Override
            public void run() {
               m_MethodChannel.invokeMethod("onSDKError", args);
            }
        });
    }

    @Override
    public void onSDKJoinChannel(int code, long channel_id, long member_count, String msg) {
        Log.i("AuviisSDK","onSDKJoinChannel");
        ArrayList<Object> args = new ArrayList<>(4);
        args.add(code);
        args.add(channel_id);
        args.add(member_count);
        args.add(msg);
//        AuviisClass.getInstance().setActiveVoiceChannel(channel_id);
//        active_channel_id = channel_id;
        runOnUiThread(new Runnable() {
            @Override
            public void run() {
                m_MethodChannel.invokeMethod("onSDKJoinChannel", args);
            }
        });
    }

    @Override
    public void onReceiveChannelMembers(long channel_id, long[] members) {
        Log.i("AuviisSDK","onReceiveChannelMembers");
        ArrayList<Object> args = new ArrayList<>(2);
        args.add(channel_id);
        args.add(members);
        runOnUiThread(new Runnable() {
            @Override
            public void run() {
                m_MethodChannel.invokeMethod("onReceiveChannelMembers", args);
            }
        });
    }

    @Override
    public void onSDKTextMessage(long sender_id, long channel_id, String msg) {
        Log.i("AuviisSDK","onSDKTextMessage");
        ArrayList<Object> args = new ArrayList<>(3);
        args.add(sender_id);
        args.add(channel_id);
        args.add(msg);
        runOnUiThread(new Runnable() {
            @Override
            public void run() {
                m_MethodChannel.invokeMethod("onSDKTextMessage", args);
            }
        });
    }

    @Override
    public void onSDKVoiceMessage(long sender_id, long channel_id, String msg_id) {
        Log.i("AuviisSDK","onSDKVoiceMessage");
        ArrayList<Object> args = new ArrayList<>(3);
        args.add(sender_id);
        args.add(channel_id);
        args.add(msg_id);
        runOnUiThread(new Runnable() {
            @Override
            public void run() {
                m_MethodChannel.invokeMethod("onSDKVoiceMessage", args);
            }
        });
    }

    @Override
    public void onSDKVoiceMessageReady(int code, long record_id) {
        Log.i("AuviisSDK","onSDKVoiceMessageReady");
        if(active_channel_id <=0) return;
//        AuviisClass.getInstance().sendVoiceChat(active_channel_id);
        ArrayList<Object> args = new ArrayList<>(2);
        args.add(code);
        args.add(record_id);
        runOnUiThread(new Runnable() {
            @Override
            public void run() {
                m_MethodChannel.invokeMethod("onSDKVoiceMessageReady", args);
            }
        });
    }

}

