<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Presigned URL — agent index

**HMAC-SHA256 signed, expiring (presigned) URLs**. Version **0.3.0**. Core `^10.3||^11`.

Sound design: `hash_hmac('sha256', host:uri:date:expires:algo, key)` + `psu-expires`. Private key env-backed (gates all signed access). Depends on core `file`.