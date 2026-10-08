<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Request Parameter Condition — agent index

A **condition plugin that evaluates request (query) parameters** (drive block visibility from `?param=value`).
Version **3.0.0**. Core `^10.5||^11.2`.

Site-building/conditions — query params are **user-controlled**: decides visibility only, **not** a security
gate (never the sole control on sensitive content). No access role.
