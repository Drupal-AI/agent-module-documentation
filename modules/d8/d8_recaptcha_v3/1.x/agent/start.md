<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# reCAPTCHA v3 (d8_recaptcha_v3) — agent index

Integrates **Google reCAPTCHA v3** (invisible, score-based) into forms. Version **dev**.

Needs a Google site key + **secret (credential — keep out of plain config)**; sends interaction
data to Google (privacy disclosure); **tune the score threshold**. Probabilistic — pair with other
controls for high-value forms.