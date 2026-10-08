<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Rankcrew (rankcrew) — agent index
**REST resources to create multilingual nodes (with base64 images/terms) from the RankCrew platform.**

- **Version:** 1.0.x
- **Core:** ^10 || ^11 · **Depends on:** rest, serialization, basic_auth
- **Resources:** `rankcrew_rankcrew` POST `/api/rankcrew` (`RankcrewResource`); vocabularies & categories resources
- **Access:** governed by core REST — needs `restful post rankcrew_rankcrew` + authentication; enable via `rest.resource.*`

**Notes:** (1) body is saved with `'format' => 'full_html'` (RankcrewResource.php:199); grant the REST permission to a dedicated API account. (2) `is_published` defaults to TRUE. (3) images are base64-only (no URL fetch); filenames use `uniqid()`. See [api/rest.md](api/rest.md).
