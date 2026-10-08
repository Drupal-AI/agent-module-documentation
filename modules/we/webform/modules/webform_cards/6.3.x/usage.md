Webform Cards adds a "Card" container element that splits a form into multiple steps paginated entirely on the client side, giving fast, no-reload multistep forms with progress indicators.

---

Webform's built-in wizard pages navigate by submitting to the server between steps, which is robust but incurs a page load per step. Webform Cards instead renders each `webform_card` container as a client-side "card" and moves between them with JavaScript, so next/previous is instant and no data is posted until the final submit. It integrates with client-side validation (its dependency `webform_clientside_validation`) so each card is validated before the user can advance, and with core Inline Form Errors for accessible per-field messages. Cards reuse Webform's progress bar/tracker styling, support conditional logic (`#states`) to show/hide or skip cards, and can be added through the Webform UI just like any other container. This is the recommended approach for long, survey-style, or conversational forms where perceived speed and smooth stepping matter. A form can mix cards with the rest of Webform's element library.

---

- Turn a long application form into a fast, no-reload multistep experience.
- Build conversational/quiz-style forms that advance one card at a time.
- Show a progress bar or step tracker across a multi-card form.
- Validate each step on the client before allowing the user to continue.
- Skip or reveal cards conditionally based on earlier answers (`#states`).
- Reduce drop-off on long surveys with instant next/previous navigation.
- Group related questions (e.g. "About you", "Your order") into cards.
- Create an onboarding flow with several quick steps.
- Provide a mobile-friendly stepped form without full page reloads.
- Add a review/summary card before the final submit.
- Combine cards with file uploads and composite elements.
- Give each card its own title used in the progress tracker.
- Let users jump back to a previous card to correct answers instantly.
- Replace server-side wizard pages to cut server round-trips.
- Present event-registration steps (attendee, sessions, payment) as cards.
- Use inline form errors for accessible per-field validation messages.
- Style cards to match a themed, branded multistep UI.
- Build a lead-qualification funnel with progressive disclosure.
- Keep all data in one submission while stepping through many cards.
- Author cards visually via the Webform UI drag-and-drop builder.
