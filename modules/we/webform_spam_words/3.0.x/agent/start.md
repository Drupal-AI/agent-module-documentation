# webform_spam_words — agent start

Blocks Webform submissions containing spam keywords. Two independent pieces: a global
settings form (defaults only — not auto-applied to any webform) and a per-webform
`webform_spam_words` submission handler that actually does the blocking once attached.
Depends only on `webform`. No config schema, no Drush, no plugin types defined.

- Global settings form + the handler that does the real work → [configure/webform-spam-words.md](configure/webform-spam-words.md)
