<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Site Info REST — agent index

A **REST resource exposing basic public site info** (name, slogan, logo, favicon — **not** version/module info).
Depends on core `rest`. Version **8.x-2.2**. Core `^9.4||^10||^11`.

Decoupled/web-services — low-sensitivity public branding; **permission-gated** REST resource (grant `restful get`
to the intended audience). No access role beyond that.
