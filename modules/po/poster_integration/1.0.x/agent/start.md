<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Poster integration — agent orientation

Commerce <-> Poster POS: import products/categories, push orders.

- Version 1.0.x, core `^8.8||^9||^10`, deps commerce/commerce_product/commerce_order. Admin `/admin/commerce/config/poster_integration` (`setup poster integration`).
- `PosterConnection` uses Guzzle over HTTPS to a HARD-CODED endpoint with DEFAULT TLS verification (not disabled). Orders pushed via `OrderCompleteSubscriber` on order place.
- `LoadHelper::saveFileToField` does `file_get_contents` on an image URL from the Poster API during admin import (isValid-checked). All routes permission-gated.