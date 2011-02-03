# A Page is a blogabble semi-static content-item.
# If <code>show_in_menu</code> the page will have a link in the
# application menu.
# Pages can be addressed by <code>/pages/OBJECT_ID</code> or
# <code>/p/TITLE_OF_THE_PAGE</code>. It can have comments and a 'cover-picture'
class Posting 
  include ContentItem
  acts_as_content_item
  has_cover_picture
    
  field :body, :type => String, :required => true
  validates_presence_of :body
  
  referenced_in :blog, :inverse_of => :postings
  referenced_in :user, :inverse_of => :postings
        
  embeds_many :comments
  validates_associated :comments
  
  embeds_many :attachments
  validates_associated :attachments
  
  validates_presence_of :user
  
  # TODO: Move this definitions to a library-module
  # TODO: and replace this lines with just 'has_attchments'
  embeds_many :attachments
  validates_associated :attachments
  accepts_nested_attributes_for :attachments,
                        :allow_destroy => true
    
  # Render the body with RedCloth
  def render_body
    RedCloth.new(body).to_html
  end
    
  private
  # Render the intro (which is the first paragraph of the body)
  def content_for_intro
    RedCloth.new(body.paragraphs[0]).to_html
  end
  

end