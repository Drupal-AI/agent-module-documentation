<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# NeutrinoAPI — agent index

A **Drupal service wrapper around NeutrinoAPI** (email validation / IP info / user-agent parsing submodules).
Version **1.0.1**. Core `^10.3||^11`.

Developer/integration — calls NeutrinoAPI with **API credentials** (secrets, HTTPS); the looked-up data
(**emails/IPs/UAs**) is **sent to NeutrinoAPI** (third-party egress/privacy — confirm acceptable/disclosed). No
access role.
