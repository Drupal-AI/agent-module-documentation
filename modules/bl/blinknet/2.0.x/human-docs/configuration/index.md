# Configuration

## 1. Enter your Blink.net account details

Go to **`/admin/config/services/blinknet`** (Configuration → Web services →
Blink.net). This page requires the **Administer blinknet** permission. Enter your
Blink.net account details here — these are the settings the blocks use to render
the correct Blink.net embeds. All configuration is kept centralized in this one
form.

## 2. Place the widget blocks

With the account configured, go to **Structure → Block layout**
(`/admin/structure/block`) and place any of the four blocks the module provides:

| Block | What it shows |
|-------|---------------|
| **Donation button** | A button-style donation call-to-action. |
| **Donation container** | A container-style donation widget. |
| **Subscription button** | A button-style subscription call-to-action. |
| **Subscription container** | A container-style subscription widget. |

Assign each block to a region and, if you like, use the block's own visibility
settings (pages, roles, content types) to control where it appears. Save the block
layout, and the Blink.net widget renders from the account details you configured in
step 1.
