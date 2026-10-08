<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Iframe Media Embed Video — agent index

Embeds **remote videos via iframe** for providers without an oEmbed provider (store an iframe embed as a
core media source). Depends on core `media`, `media_library`. Version **1.0.6**. Core `^8.8||^9||^10||^11`.

**Security:** renders an **iframe to a remote source** — restrict embedding to trusted editors + prefer an
allow-list of trusted video domains (arbitrary-URL iframe = clickjacking/malicious-content vector). No access
role.
