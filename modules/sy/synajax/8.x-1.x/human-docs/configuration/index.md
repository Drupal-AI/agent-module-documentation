# Configuration

SynAjax is configured from its own settings form, provided at the
`synajax.config` route. Open it as a user with permission to administer site
configuration.

## Turn on AJAX-only submission

The settings form is where you enable SynAjax's core behaviour — requiring
contact forms to be submitted through AJAX (JavaScript) rather than a plain
direct POST. With this switched on, a bot that simply POSTs to the form's URL
without running JavaScript is turned away, while an ordinary visitor's browser
submits the form over AJAX as normal.

Apply it to the contact forms you want protected, then save. Because the whole
point is a JavaScript-driven submission, test each protected contact form in a
real browser afterwards to confirm legitimate submissions still go through.

## What to keep in mind

- **It is one layer, not a complete defence.** AJAX-only submission stops naive
  bots that never run JavaScript, but not a headless browser or a determined
  spammer that does. For anything that needs real protection, combine SynAjax
  with CAPTCHA, Honeypot or Drupal's flood control.
- **No-JS visitors.** Requiring JavaScript to submit means a visitor with
  JavaScript disabled cannot submit the form. Weigh that accessibility trade-off
  for your audience before relying on it.
- **No access-control role.** SynAjax is purely a spam-reduction aid; it does not
  govern who may see or reach a form.
