json.ignore_nil!
json.errors do
    json.array! @errors, :code, :field, :fields
end
