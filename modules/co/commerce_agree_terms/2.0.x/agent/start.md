# Commerce Agree to Terms — agent index

One Commerce checkout pane (`agree_terms`) that renders a required "I agree to the Terms and
Conditions" checkbox linking to a node, and blocks checkout completion until it is ticked.
No global config page (`configure` null), no permissions, no Drush. Depends on `commerce_checkout`.

- **Place & configure the pane, every setting key, where config is stored, validation behavior** →
  [configure/pane.md](configure/pane.md)

Key facts:
- Plugin id `agree_terms`, default step `review` (`src/Plugin/Commerce/CheckoutPane/AgreeTerms.php`).
- Config stored on the checkout flow: `commerce_checkout.commerce_checkout_pane.agree_terms`
  (keys `nid`, `link_text`, `prefix_text`, `description`, `invalid_text`, `new_window`).
- Configure via UI only: *Commerce → Configuration → Checkout flows → (flow) → Edit*.
