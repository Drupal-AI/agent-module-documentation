# Configuration

All of Language Suggestion's behaviour is set on one form.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Regional and language → Language Suggestion**, or
   navigate directly to `/admin/config/regional/language-suggestion`.

## The settings, field by field

### Container CSS element

The selector for the main page container the suggestion box attaches to. It
defaults to the `body` tag. Change it if you already have other message boxes at
the top of the page (a cookie notice, for example) and want the suggestion box to
sit relative to a different element.

### Always redirect

When enabled, this adds an automatic redirect based on the visitor's *previous*
language selection — so a returning visitor who once chose a language is sent
straight there. Leave it off if you want to keep the experience purely as a
suggestion.

### Language switch CSS element

This overrides the automatic redirect. If you use **Always redirect** but still
want a visitor to be able to switch to another language afterwards, specify the
class name or ID of your language‑switch element here so that control keeps
working.

### Language suggestion delay

How long to wait, **in seconds**, before the suggestion box appears. A short delay
lets your page settle before the box pops in.

### Dismiss delay

How long the suggestion box stays hidden after a visitor dismisses it, before it
is allowed to reappear.

### Browser language mapping

This is the heart of the module: the mapping that decides **when** a suggestion is
shown. For each browser language you care about, add an entry mapping it to the
site language you want to suggest. If a visitor's browser language has no entry
here, no suggestion appears — so this is where you enable the languages you
support. You can also set a custom prompt message per language.

> **Tip:** If a visitor reports never seeing the box, have them check what their
> browser actually reports as its language (any "what's my browser" site shows
> this), and make sure that exact language has a row in the mapping.

### Browser‑based vs HTTP header‑based detection

Choose how the visitor's language is detected. **Browser‑based** detection is the
default and most reliable. **HTTP header‑based** detection is marked
**experimental** — use it only if you specifically need header‑driven negotiation
and have tested it on your setup.

### MaxMind GeoIP2 Country database

Optionally integrate a MaxMind GeoIP2 Country database for country‑level
detection. This is only needed if you want to base suggestions on the visitor's
country rather than purely on their browser language.

## Save

Click **Save configuration**. Test as a fresh visitor whose browser language
matches one of your mapping entries — the suggestion box should appear after the
configured delay, offering to switch, without redirecting them unless you enabled
**Always redirect**.
