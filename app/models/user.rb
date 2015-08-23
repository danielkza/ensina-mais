class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :trackable, :registerable, :rememberable,
          :validatable, :omniauthable, omniauth_providers: [:facebook]

  def password_required?
    uid.nil?
  end

  def self.from_omniauth(auth)
    user = find_by(provider: auth.provider, uid: auth.uid)
    unless user
      user = User.new(provider: auth.provider, uid: auth.uid)
      user.email = auth.info.email
      user.password = Devise.friendly_token[20]
      user.name = auth.info.name
    end
    
    user.image = auth.info.image
    user.location = auth.info.location

    if extra = auth.extra.raw_info
      user.genre = extra['gender'] if extra['gender']

      if extra['birthday'] && extra['birthday'].count('/') != 1
        user.birth_year = extra['birthday'].rpartition('/').last.to_i
      end

      if extra['work']
        user.work = extra['work'].map { |work|
          work_exp = work['employer'] ? work['employer']['name'] : ''
          pos = work['position']['name']
          work_exp << " - "  + pos if pos
          loc = work['location']['name']
          work_exp << " - "  + loc if loc
          work_exp.empty? ? nil : work_exp
        }.compact.join('\n')
      end

      if extra['education']
        user.study = extra['education'].map { |edu|
          ed_exp = edu['type'] || ''
          school = edu['school'] && edu['school']['name']
          ed_exp << " - "  + school if school
          conc = edu['concentration'] && edu['concentration']['name'] if
          ed_exp << " - "  + conc if conc
          yr = edu['year'] && edu['year']['name']
          ed_exp << " - " + yr if yr
          ed_exp.empty? ? nil : ed_exp
        }.compact.join('\n')
      end
    end

    Rails.logger.info(user)
    user.save
    user
  end

  def types
    %w(Teacher Student Industry)
  end
end
