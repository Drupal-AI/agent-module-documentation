<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mail Action — agent index

Provides **action plugins for sending emails with formatted text** (usable from VBO/ECA/bulk flows). Version
**1.0.0**. Core `^10.3||^11`.

Automation/mail — **caveat:** a send-email action (esp. via VBO) can **mass-email** recipients — **gate it to
trusted roles** (avoid spam/relay abuse); keep content trusted. No access role of its own.
