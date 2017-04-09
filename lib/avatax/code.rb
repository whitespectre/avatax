module Avatax
  ##
  # Contains codes for voiding transactions. See api docs
  # for expected behavior.
  # @see http://developer.avalara.com/avatax/voiding-documents/
  #
  module Code
    POST_FAILED           = 'PostFailed'.freeze
    DOC_DELETED           = 'DocDeleted'.freeze
    DOC_VOIDED            = 'DocVoided'.freeze
    ADJUSTMENT_CANCELLED  = 'AdjustmentCancelled'.freeze
  end
end
