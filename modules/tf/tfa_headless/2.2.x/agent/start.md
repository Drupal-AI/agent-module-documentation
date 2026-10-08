<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# TFA Headless — agent index

**A headless (API) implementation for the TFA module** — requires TFA before Simple OAuth issues a token (alters
`/oauth/token`). Depends on `tfa`, `rest`, `simple_oauth`, `restui`. Version **2.2.3**. Core `^9||^10||^11`.

Authentication — value depends on TFA being **enforced, not bypassable**: verify a client can't get a usable token
without the second factor (test refresh/edge cases); secure the Simple OAuth keys; HTTPS.
