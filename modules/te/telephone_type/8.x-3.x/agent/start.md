<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Telephone Type — agent index

Field type extending **core Telephone** with an optional **phone-type** selector (mobile/home/work/fax). Version **8.x-3.4**. Core `^8.9 || ^9 || ^10`.

Depends on core telephone + field. Provides field type/widget/formatter and a `telephone_type.validator` service. No routes, no permissions, no external calls — field access follows the host entity.
