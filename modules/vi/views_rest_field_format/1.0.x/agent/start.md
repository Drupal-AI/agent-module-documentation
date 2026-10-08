<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views REST Field Format — agent index

A **Views row plugin defining REST export data format field-by-field** (finer control over export structure/
naming vs whole-row serialization). Depends on core `views`. Version **1.0.2**. Core `^10.3||^11`.

Web-services — shapes REST export output; exported data reflects what the View exposes (respects the View's
access; ensure it doesn't over-expose fields). No access role.
