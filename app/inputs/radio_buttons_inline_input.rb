class RadioButtonsInlineInput < SimpleForm::Inputs::CollectionRadioButtonsInput
  def input(wrapper_options = nil)
    label_method, value_method = detect_collection_methods
    input_options[:item_label_class] = 'btn btn-secondary'
    input_options[:item_wrapper_tag] = nil
    input_options[:wrapper_html] = { 'data-toggle' => 'buttons', class: 'btn-group' }

    @builder.send("collection_radio_buttons",
                  attribute_name,
                  collection,
                  value_method,
                  label_method,
                  input_options,
                  input_html_options,
                  &collection_block_for_nested_boolean_style)
  end
end

