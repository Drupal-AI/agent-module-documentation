# seo_checklist — agent start

A curated, persistent checklist of Drupal SEO tasks built on **Checklist API**. Implements
`hook_checklistapi_checklist_info()` to register one checklist (`seo_checklist`) whose items
recommend and link to SEO contrib modules (redirect, pathauto, metatag, simple_sitemap,
robotstxt, google_tag, easy_breadcrumb, yoast_seo, security_review, …) and technical steps,
grouped into sections. It provides no config form, permissions, services, or Drush commands of
its own — Checklist API supplies the route, permissions, UI, and progress persistence. The
checklist lives at **Admin → Config → Search and metadata → SEO Checklist**
(`/admin/config/search/seo-checklist`); `configure` route `checklistapi.checklists.seo_checklist`.

- Where the checklist lives, how progress/auto-detection works → [configure/seo_checklist.md](configure/seo_checklist.md)
- The `hook_checklistapi_checklist_info()` it implements + augmented item schema (`#module`, `#configure`, `#seo_training_camp`) and how to alter it → [hooks/seo_checklist.md](hooks/seo_checklist.md)
