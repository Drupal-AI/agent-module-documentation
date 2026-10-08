# Configure the Load More pager on a view

Views Load More has **no admin settings page** (`configure: null`). You select and configure
it per view display, in the display's **Pager** section.

## Enable it (Views UI)

1. Edit the view, on the display click the **Pager** setting (usually "Mini"/"Full").
2. Choose **Load more pager** (`Paged output, each page loaded via AJAX`), Apply.
3. In the pager options set **Items to display**, optional **Offset**, the button text, etc.
4. **Enable AJAX** on the display (Advanced → Use AJAX: Yes) so pages append instead of reload.

## Options (stored in the display's `pager.options`)

| Option key | Form label | Default | Purpose |
|---|---|---|---|
| `items_per_page` | Items to display | 10 | inherited from Full pager |
| `offset` | Offset | 0 | inherited from Full pager |
| `more_button_text` | Load more text | `Load more` | label on the button/link |
| `end_text` | Finished text | `` (empty) | shown in place of the button on the last page, e.g. "No more results" |
| `effects.type` | Effect Type | `` (None) | `` \| `fadeIn` \| `slideDown` — jQuery animation for appended rows |
| `effects.speed` | Effect Speed | — | `slow` \| `fast` (only relevant with an effect) |
| `advanced.content_selector` | Content selector | `` → `> .view-content` | jQuery selector (relative to view container) for the rows wrapper; set when overriding row markup |
| `advanced.pager_selector` | Pager selector | `` → `.pager--load-more` | jQuery selector for the pager; set when overriding pager markup |

`tags` and `quantity` (page-number options of the Full pager) are removed from the form —
they are meaningless for a load-more button.

## Config (exported YAML)

Inside `views.view.<id>` for the display, e.g.:

```yaml
display:
  default:
    display_options:
      pager:
        type: load_more
        options:
          items_per_page: 10
          offset: 0
          more_button_text: 'Show me more'
          end_text: 'No more results'
          effects:
            type: fadeIn
            speed: slow
          advanced:
            content_selector: ''
            pager_selector: ''
      use_ajax: true
```

Config schema id `views.pager.load_more` (extends `views.pager.full`) validates
`more_button_text`, `end_text`, `advanced.content_selector`, `advanced.pager_selector`,
`effects.type`, `effects.speed`.

## Read it back

```bash
drush cget views.view.<view_id> display.default.display_options.pager
# type should be load_more; check options.more_button_text / options.end_text
```

## Notes

- With **AJAX disabled** the pager still renders — the button is a normal next-page link, so
  it degrades to standard paging. The append behavior only runs on AJAX responses.
- The empty-string defaults for `more_button_text` / selectors are replaced at runtime by
  the plugin's constants/`t('Load more')`, so an empty stored value is normal.
