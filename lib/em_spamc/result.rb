class EmSpamc::Result
  # == Constants ============================================================

  ATTRIBUTES = [
    :headers,
    :threshold,
    :tags,
    :report
  ].freeze

  # == Instance Methods =====================================================

  def initialize(attributes = nil)
    @attributes = attributes || { }
  end

  ATTRIBUTES.each do |name|
    define_method(name) do
      @attributes[name]
    end

    define_method(:"#{name}=") do |value|
      @attributes[name] = value
    end
  end

  def spam?
    headers[:spam] if headers
  end
end
