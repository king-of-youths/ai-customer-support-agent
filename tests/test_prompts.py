#!/usr/bin/env python3
"""
Unit tests for AI Customer Support Agent Prompts and Guardrails
"""

import os
import unittest
import json

class TestPrompts(unittest.TestCase):
    def setUp(self):
        self.base_dir = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
        self.prompts_dir = os.path.join(self.base_dir, "prompts")

    def test_prompts_exist(self):
        expected_files = [
            "system_prompt.md",
            "intent_classification.md",
            "guardrails.md",
            "lead_extraction.md",
            "appointment_extraction.md"
        ]
        for f in expected_files:
            file_path = os.path.join(self.prompts_dir, f)
            self.assertTrue(os.path.exists(file_path), f"Missing prompt file: {f}")

    def test_system_prompt_has_critical_rules(self):
        sys_prompt_path = os.path.join(self.prompts_dir, "system_prompt.md")
        with open(sys_prompt_path, "r", encoding="utf-8") as f:
            content = f.read()
        self.assertIn("Absolute Grounding", content)
        self.assertIn("Zero Hallucination", content)
        self.assertIn("Apex Solutions", content)

    def test_intent_classification_categories(self):
        intent_path = os.path.join(self.prompts_dir, "intent_classification.md")
        with open(intent_path, "r", encoding="utf-8") as f:
            content = f.read()
        required_intents = ["FAQ", "Product", "Pricing", "Lead", "Appointment", "Complaint", "Human", "Unknown"]
        for intent in required_intents:
            self.assertIn(intent, content)

    def test_workflows_json_validity(self):
        wf_dir = os.path.join(self.base_dir, "workflows")
        for wf_file in os.listdir(wf_dir):
            if wf_file.endswith(".json"):
                path = os.path.join(wf_dir, wf_file)
                with open(path, "r", encoding="utf-8") as f:
                    data = json.load(f)
                self.assertIn("name", data, f"Workflow {wf_file} missing 'name'")
                self.assertIn("nodes", data, f"Workflow {wf_file} missing 'nodes'")
                self.assertIn("connections", data, f"Workflow {wf_file} missing 'connections'")

if __name__ == "__main__":
    unittest.main()
