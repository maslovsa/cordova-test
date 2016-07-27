/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

function onRecievePushNotification(params){
    alert("Message id - " + params.rkMsgId);
    
    var success = function(message) {

    }
    
    var failure = function() {

    }
    
    rokomobi.addEvent({name: "PUSH - " + params.rkMsgId}, success, failure);
}

function onHandleDeepLink(message){
    var text =  message.name + ' - name \n'
    + message.createDate + ' - createDate \n'
    + message.updateDate + ' - updateDate \n'
    + message.shareChannel + ' - shareChannel \n'
    + message.vanityLink + ' - vanityLink \n'
    + message.customDomainLink + ' - customDomainLink \n'
    + message.type + ' - type \n'
    + message.referralCode + ' - referralCode \n'
    + message.promoCode + ' - promoCode \n'
    console.log(text);
    alert("onHandleDeepLink");
}

var app = {
    // Application Constructor
    initialize: function() {
        this.bindEvents();
    },
    // Bind Event Listeners
    //
    // Bind any events that are required on startup. Common events are:
    // 'load', 'deviceready', 'offline', and 'online'.
    bindEvents: function() {
        document.addEventListener('deviceready', this.onDeviceReady, false);
    },
    // deviceready Event Handler
    //
    // The scope of 'this' is the event. In order to call the 'receivedEvent'
    // function, we must explicitly call 'app.receivedEvent(...);'
    onDeviceReady: function() {
        app.receivedEvent('deviceready');

        var success = function(message) {
            alert(message);
        }

        var failure = function() {
            alert("Error calling");
        }

        rokomobi.setUser({userName: "tony_hawk"}, success, failure);
        rokomobi.addEvent({name: "My first event"}, success, failure);
    },
    // Update DOM on a Received Event
    receivedEvent: function(id) {
        var parentElement = document.getElementById(id);
        var listeningElement = parentElement.querySelector('.listening');
        var receivedElement = parentElement.querySelector('.received');

        listeningElement.setAttribute('style', 'display:none;');
        receivedElement.setAttribute('style', 'display:block;');

        console.log('Received Event: ' + id);
    }
};

app.initialize();
