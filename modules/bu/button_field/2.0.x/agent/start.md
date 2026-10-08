<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Button Field — agent index

A **field type that renders a button which triggers an event when clicked**. Depends on core `field`. Version
**2.x** (dev). Core `^10.3||^11`.

Fields/interaction — the button **triggers an action**: ensure that action is **access-controlled + CSRF-
protected** (the handler must enforce security; the button is just a trigger). No access role of its own.
