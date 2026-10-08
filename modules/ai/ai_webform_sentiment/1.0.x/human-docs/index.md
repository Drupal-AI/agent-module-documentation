# AI Webform Sentiment — manual setup guide

**AI Webform Sentiment** (`ai_webform_sentiment`) analyzes Webform submissions
for sentiment using AI and visualizes the result with Chart.js. It reads the text
people submit through a form and uses the AI module's configured provider to
judge whether the tone is positive, negative, or neutral — useful for feedback
forms, surveys, and contact forms where you want a quick read on how respondents
feel without reading every entry by hand.

It builds on the AI module and the Webform module, and uses the Chart.js API
module to draw the sentiment charts. Because it works by **sending submission
text to the configured AI provider**, the same care applies as with any AI
feature: submissions may contain personal data, so confirm that sending them out
is acceptable; there is a per‑call cost; and the provider's API key is kept as a
secret through the AI module's Key configuration.

It has no access‑control role beyond its own permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Sentiment results are shown against Webform submissions in the Webform UI
(**Structure → Webforms**), rendered as Chart.js visualizations. The AI provider
is configured in the **AI** module; this module has no standalone settings page.

## How to use it

1. Make sure the **Webform**, **AI** (with a working provider), and **Chart.js
   API** modules are set up.
2. Enable AI Webform Sentiment and grant its permission to the staff who should
   view the analysis.
3. Collect submissions, then view the sentiment analysis and charts for a
   webform's submissions.

> **Privacy:** submission text is sent to your AI provider for analysis. Confirm
> this is acceptable for the personal data your forms collect.
