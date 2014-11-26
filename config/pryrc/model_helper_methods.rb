def show_columns(object, *search_terms)
  search_terms.map { |search_term|
    object.attributes.slice(*object.attributes.keys.grep(/#{search_term}/))
  }.reduce({}, :merge)
end

def row_where(relation, search_term, *columns)
  query = relation
  columns.each do |column|
    query = query.where("#{column} IS #{search_term.to_s.humanize.upcase}")
  end
  query.first
end
