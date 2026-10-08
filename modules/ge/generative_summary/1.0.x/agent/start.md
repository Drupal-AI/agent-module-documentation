<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Generative Summary — agent index

Adds a **"Generate Summary" button** that uses **OpenAI** to draft a field's summary. Depends on core `field`.
Version **1.0.3**. Core `^10||^11`.

AI/content-editing — **sends field content to OpenAI** (egress — confirm acceptable); **API key** as a secret
(HTTPS); limit the button to trusted editors (usage/cost). No access role.
