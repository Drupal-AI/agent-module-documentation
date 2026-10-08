# TencentCloud Captcha — manual setup guide

**TencentCloud Captcha** (`tencentcloud_captcha`) adds
[Tencent Cloud](https://cloud.tencent.com)'s CAPTCHA service as a challenge type
for Drupal's CAPTCHA module. Once configured, forms on your site can present
TencentCloud's bot‑protection challenge to block spam and automated submissions.

It solves the same problem as any CAPTCHA integration — keeping bots out of your
forms — but is particularly useful for sites serving audiences in China, where
Google reCAPTCHA is often unreachable. It builds directly on the CAPTCHA module:
CAPTCHA provides the framework that decides which forms are protected, and this
module supplies TencentCloud as one of the available challenge providers. The
challenge is verified server‑side against Tencent's API, so a valid response
cannot simply be faked in the browser.

This module does **not** do anything useful on‑enable — you must supply your
Tencent Cloud credentials and choose which forms to protect before it takes
effect. It depends on the **CAPTCHA** module (`captcha`) and pulls in the
`tencentcloud/captcha` PHP package automatically via Composer. It supports
**Drupal 9.3, 10, and 11**, and ships no submodules. Your Tencent API credentials
are secrets and should be stored securely (env‑backed) rather than committed to
code.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enter your Tencent credentials and
   choose which forms to protect.

## Where it lives in the admin menu

Its settings form sits under the CAPTCHA settings area at
**Configuration → People → CAPTCHA → TencentCloud**
(`/admin/config/people/captcha/tencentcloud_captcha`). The general CAPTCHA
settings, where you decide which forms get a challenge, are at
`/admin/config/people/captcha`.
