# link_attributes_menu_link_content — agent start

Submodule of link_attributes. Adds the link
attribute inputs (target, rel, class, aria-label, …) to the **content menu link** edit form
(`menu_link_content` entity). Depends on `link` + `link_attributes`.

No config UI. It works through `LinkAttributesMenuLinkContentHooks` (autowired via
`link_attributes_menu_link_content.services.yml`), which adds the attribute widgets to the
menu-link form and saves them onto the link. Available attributes and their YAML plugins are
inherited from the parent module — see
link_attributes plugins.
