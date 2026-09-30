#!/usr/bin/env python3
"""
Telegram Webhook Simulator
Sends simulated Telegram webhook payloads to an n8n webhook URL for quick testing.
"""

import sys
import os
import json
import argparse
import urllib.request
import urllib.error

def send_mock_telegram_message(webhook_url: str, text: str, user_id: int = 12345678, name: str = "Test User", username: str = "testuser"):
    payload = {
        "update_id": 99999999,
        "message": {
            "message_id": 101,
            "from": {
                "id": user_id,
                "is_bot": False,
                "first_name": name.split()[0],
                "last_name": " ".join(name.split()[1:]) if len(name.split()) > 1 else "",
                "username": username,
                "language_code": "en"
            },
            "chat": {
                "id": user_id,
                "first_name": name.split()[0],
                "last_name": " ".join(name.split()[1:]) if len(name.split()) > 1 else "",
                "username": username,
                "type": "private"
            },
            "date": 1727733600,
            "text": text
        }
    }

    req = urllib.request.Request(
        webhook_url,
        data=json.dumps(payload).encode("utf-8"),
        headers={"Content-Type": "application/json"}
    )

    try:
        print(f"-> Sending message to {webhook_url}: \"{text}\"")
        with urllib.request.urlopen(req) as response:
            res_body = response.read().decode("utf-8")
            print(f"<- Response [{response.status}]: {res_body}")
    except urllib.error.HTTPError as e:
        print(f"<- HTTP Error [{e.code}]: {e.read().decode('utf-8')}")
    except Exception as e:
        print(f"<- Connection error: {e}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Simulate Telegram Webhook request to n8n")
    parser.add_argument("--url", default="http://localhost:5678/webhook/customer-support-main", help="n8n webhook URL")
    parser.add_argument("--message", default="Hello, what services do you offer?", help="Message text to send")
    parser.add_argument("--name", default="Alex Doe", help="Customer name")
    parser.add_argument("--id", type=int, default=12345678, help="Telegram user ID")
    args = parser.parse_args()

    send_mock_telegram_message(args.url, args.message, args.id, args.name)
