<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Knowledge provides a knowledge-base and competency system with adherence, quality and audience controls.

---

Knowledge is a comprehensive knowledge/competency management system: it lets users link incidents to content and manage knowledge articles, competencies, adherence and quality entities, with audience segmentation (internal/partner/customer/external), approval workflow (content moderation), and search integration. It's aimed at learning/knowledge-management use cases.

It exposes a very large, granular permission set (knowledge/competency/adherence/quality CRUD, approval skip, audience visibility, revisions) — audience and approval permissions are security-relevant, so map them carefully to roles. Depends on `autocomplete_id`, core `content_moderation`/`field`/`options`/`text`, `search_api`, `token`, and its `knowledge_field` submodule; supports Drupal 10 and 11.

---

- Manage a knowledge base.
- Link incidents to content.
- Track competencies.
- Manage adherence and quality entities.
- Segment by audience (internal/partner/customer/external).
- Use content-moderation approval.
- Integrate search (Search API).
- Expose a large granular permission set.
- Gate audience visibility permissions.
- Gate approval-skip carefully.
- Map permissions to roles carefully.
- Depend on `autocomplete_id` and `knowledge_field`.
- Depend on core `content_moderation`, `search_api`, `token`.
- Support Drupal 10 and 11.
- Support learning/KM use cases.
- Handle knowledge revisions.
- Manage competencies per learner
- Approve knowledge content
