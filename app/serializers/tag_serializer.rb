class TagSerializer < ActiveModel::Serializer
  attributes :id, :tag_content, :tag_type
  belongs_to :url
end
