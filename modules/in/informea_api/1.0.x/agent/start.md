<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# InforMEA API — agent index

Tools to **expose content via REST** for the InforMEA platform (build REST views/endpoints in InforMEA's
format). Depends on core `rest`. Version **1.0.0-alpha16**. Core `^8||^9||^10||^11`.

Decoupled/integration — publishes via **REST**: ensure only **public** content is exposed (rely on resource/
view + entity access; don't surface unpublished/restricted data); secure the endpoints. No access role of its
own.
