Adds a toolbar button to CKEditor 5 that toggles the editing area between a light and a dark theme.

---

CKEditor 5 Dark Mode is a small, front-end-only CKEditor 5 plugin for Drupal. It registers a single toolbar button ("Dark Mode") that, when clicked, adds a `ck-dark` CSS class to the editor's editing region and swaps the button icon/label to "Light Mode"; clicking again removes the class and reverts. The dark styling is delivered entirely through the module's CSS libraries — there is no PHP, no route, no permission, and no stored configuration. The toggle is purely visual and per-session (the state is held in a JS variable and resets on reload). It is most useful when editors use light-colored text (via a font-color or font plugin) that would otherwise be invisible on the default white editing background, and it also ships a few CSS tweaks to smooth over color issues with the Gin admin theme. To use it, enable the module and add the Dark Mode button to a text format's CKEditor 5 toolbar at Administration > Configuration > Content authoring > Text formats and editors.

---

- Give content editors a one-click way to flip the CKEditor 5 editing area to a dark background while writing.
- Make white or light-colored text (set via CKEditor 5 Font's text-color feature) readable inside the editor instead of white-on-white.
- Pair with the CKEditor 5 Font plugin (Text Color / Background Color) so light font colors preview against a dark canvas.
- Pair with CKEditor Font Size and Family when authors use light text colors.
- Reduce eye strain for editors who prefer working on a dark UI during long editing sessions.
- Add the Dark Mode button only to specific text formats (e.g. Full HTML) via the text-format toolbar configuration.
- Offer a dark editing surface without changing the site's overall admin theme.
- Work around a few Gin admin theme color conflicts in the editor using the bundled admin CSS.
- Preview how light-on-dark content will look before publishing, without touching front-end styles.
- Let authors toggle back to light mode instantly when they need the standard white canvas again.
- Provide a dark editing option on Drupal 8.8 through Drupal 11 sites using core CKEditor 5.
- Improve contrast for editors working in low-light environments.
- Keep the toggle scoped to the editor only, leaving stored HTML markup unchanged.
- Add a familiar dark-mode affordance to the rich-text editing experience.
- Demonstrate a minimal, dependency-light CKEditor 5 plugin for developers learning the plugin system.
- Combine with other CKEditor 5 UI plugins in the same toolbar without conflicts (it only adds a `ck-dark` class).
- Enable per-editor visual preference without persisting anything server-side.
- Support multiple text formats by adding the button to each format's toolbar independently.
