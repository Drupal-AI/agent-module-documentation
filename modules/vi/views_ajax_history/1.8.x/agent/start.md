# views_ajax_history — agent start

Makes AJAX-enabled Views push filter/pager state into the browser URL and history, so
back/forward buttons and bookmarking work. Depends only on core `views`. No admin settings
page — it is configured **per view** via a Views display extender (`ajax_history`) that adds
an "AJAX history" checkbox next to the view's *Use AJAX* option. No permissions, no Drush.

- Enable & configure history on a view (display extender, exclude-args) → [configure/views_ajax_history.md](configure/views_ajax_history.md)
- How the JS library hooks Views AJAX + the History API → [theming/views_ajax_history.md](theming/views_ajax_history.md)
