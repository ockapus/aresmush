module AresMUSH
  module Login
    class CheckTokenRequestHandler
      def handle(request)
                
        id = request.args[:id]
        token = request.args[:token]
        
        char = Character.find_one_by_name(id)
        if (!char)
          return { error: t('webportal.not_found') }
        end
        
        if (char.is_statue?)
          return { error: t('dispatcher.you_are_statue') }
        end
        
        if (!char.is_valid_api_token?(token))
          return { error: t('webportal.session_expired') }    
        end
        
        {
          token: char.login_api_token,
          name: char.name,
          id: char.id,
          is_approved: char.is_approved?,
          is_admin: char.is_admin?,
          is_coder: char.is_coder?
        }
      end
    end
  end
end