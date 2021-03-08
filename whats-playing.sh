#!/bin/bash

LASTFM_API_KEY="add_your_lastfm_api_key"

function go() {
    __whats_playing
}

function __whats_playing() {

    curl_url="http://ws.audioscrobbler.com/2.0/?method=user.getrecenttracks&user=reydh&api_key=$LASTFM_API_KEY&format=json"

    curl_response=$(curl --silent $curl_url)

    now_playing=$(echo $curl_response | jq --raw-output '.recenttracks.track[0]."@attr".nowplaying')
    track_artist=$(echo $curl_response | jq --raw-output '.recenttracks.track[0].artist."#text"')
    track_name=$(echo $curl_response | jq --raw-output '.recenttracks.track[0].name')

    if [[ "$now_playing" == "true" ]]; then
        echo "📻 Playing $track_name by $track_artist"
    else
        echo "📻 Not playing"
    fi
}

go
