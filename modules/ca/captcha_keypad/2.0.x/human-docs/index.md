# Captcha Keypad — manual setup guide

**Captcha Keypad** (`captcha_keypad`) is a click-based CAPTCHA challenge. Instead of
asking a visitor to decipher distorted text, the form shows a short numeric code and
an on-screen number keypad, and the user simply clicks the code's digits in
sequence. There is nothing to type and nothing to squint at, which makes it fast and
touch-friendly on phones and kinder to users who struggle with warped letters. The
keypad can also shuffle its button positions on every page load, so a bot that reads
the target code still cannot reliably map it to screen coordinates.

The module offers three display themes (Plain, Horizontal, and Vertical), inline
validation feedback, an admin-exempt mode so site builders are never locked out, and
an environment-aware bypass so automated test suites can run without solving the
challenge. It is designed to work as a challenge *type* for Drupal's **CAPTCHA**
module, letting you place it on user registration, login, password reset, contact
forms, forum comments, Webforms, and more.

**Important — always run this module together with the CAPTCHA module.** When
CAPTCHA drives the keypad, the challenge is generated and its answer stored and
validated **server-side**, which is correct and secure. The module also has a
standalone mode (used when the CAPTCHA module is *not* installed) that validates the
challenge against a value the browser itself submits, with no server-side secret — a
script posting two matching fields can satisfy it, so in standalone mode the keypad
stops nothing. There is also a test shortcut where setting the code size to `99`
lets a fixed string pass. The practical rule is simple: **run it only with the
CAPTCHA module enabled, never standalone, and keep the code size at a normal value
(not 99).** Configured that way it is a genuine, accessible bot deterrent;
configured standalone it is decoration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, and enable it
   **together with** the CAPTCHA module.
2. [Configuration](configuration/index.md) — the settings form: code length,
   display theme, keypad shuffling, and the admin-exempt option.

## Where it lives in the admin menu

The module's own settings form is at `captcha_keypad.settings`. When you use it as a
CAPTCHA type (the recommended way), you then assign the keypad challenge to specific
forms from the CAPTCHA module's *CAPTCHA points* administration pages. Its settings
are gated by the module's own administration permission — grant it only to trusted
administrators.
