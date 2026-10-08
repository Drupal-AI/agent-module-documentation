<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Labels and Values Tokens (webform_labels_values_tokens) — agent index

**Token provider that prints Webform submission element labels with their values, skipping empty ones.**

- **Version:** 1.0.x
- **Core:** ^10 || ^11
- **Dependency:** webform
- **Interface:** token hooks only — no routes, permissions, services or config
- **Use:** insert the provided tokens in Webform email handlers / confirmation messages
- **Security:** No HTTP surface, no configuration, no external calls; output is built from submission data via the token system. No security findings.
