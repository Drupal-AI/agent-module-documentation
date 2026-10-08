Submodule of Link attributes that lets editors set HTML link attributes (target, rel, class, etc.) directly on content menu links in the menu-link-content edit form.

---

Content menu links (the ones created under Structure → Menus) store their own URL but, like link fields, offer no UI for HTML attributes. This submodule reuses the Link attributes plugin system to add an attributes section to the menu-link-content form, so an editor can, for example, make a menu item open in a new tab, add a `rel="nofollow"`, or attach a CSS class for styling. It works via hook implementations (`LinkAttributesMenuLinkContentHooks`) that inject the attribute widgets and persist the values on the `menu_link_content` entity. The same attributes and YAML plugins defined for the parent module are available here. Enable it whenever you need per-menu-item attribute control rather than per-field.

---

- Make a specific menu item open in a new tab (`target="_blank"`).
- Add a CSS class to a menu link for custom styling.
- Add `rel="nofollow"` to an external menu link.
- Add `rel="noopener"` for security on external nav items.
- Set an `aria-label` on an icon-only menu link.
- Add a `title` tooltip to a navigation item.
- Attach a tracking/analytics class to menu links.
- Style a "Contact us" menu item as a button.
- Give a menu link an `id` for JS targeting.
- Apply the same attribute plugins used on link fields to menu links.
- Flag call-to-action menu items with a utility class.
- Add accessibility attributes to primary navigation.
- Control which attributes are available on menu links.
- Mark download links in the menu with a data attribute.
- Provide consistent external-link behaviour across menus.
