<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Helpfulness — agent index

Provides a **feedback block** for users ("was this helpful?" + optional comment — gauge content usefulness).
Config at `helpfulness.admin_form`; provides permissions. Version **2.1.3**. Core `^8.8||^9||^10||^11`.

**Security:** free-text comments are user input — sanitize on display (stored-XSS), guard spam (flood/CAPTCHA
if anonymous); gate who views feedback. No content-access role beyond permission.
