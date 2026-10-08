<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Salesforce Web2Lead Webform Handler — agent index

A **Webform handler that submits form data to Salesforce Web-to-Lead** (create CRM leads via your org ID).
Depends on `webform`. Version **1.0.1**. Core `^10||^11`.

Forms/CRM — sends **submitter PII** to Salesforce (egress; privacy policy); Web-to-Lead is **unauthenticated by
design**, so apply **spam/bot protection** (CAPTCHA/honeypot) to the form; HTTPS. No access role.
