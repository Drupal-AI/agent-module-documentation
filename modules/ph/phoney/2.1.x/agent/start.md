<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Phoney — agent index

A **Twig template that obfuscates a phone-number field (`field_phone`)** on display (deter simple scrapers).
Depends on core `field`. Version **2.1.0**. Core `^11`.

**Caveat — NOT real protection:** the number is still delivered to the browser (obtainable via source/
deobfuscation/reading). Reduces casual harvesting only — don't rely on it to keep a number private (don't
publish it at all in that case). No access role.
