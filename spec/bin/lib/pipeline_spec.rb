require 'spec_helper'

describe Pipeline::Utility::PaperTrail do
  include WebMock::API
  
	describe '.generate_papertrail_id' do
		context 'when a valid aws private_ip address is passed in' do
      let(:private_ip) { '10.43.23.56' }
			let(:result) { 'ip-10-43-23-56' }

			subject {
				Pipeline::Utility::PaperTrail.generate_papertrail_id(private_ip)
			}

			it { should_not be_nil }
			it { expect(subject).to eq(result) }
		end

		context 'when an invalid private_ip address is passed in' do
		  let(:private_ip) { '' }
			let(:result) { '' }

			subject {
				Pipeline::Utility::PaperTrail.generate_papertrail_id(private_ip)
			}

			it { should_not be_nil }
			it { expect(subject).to eq(result) }
		end	
	end
	
	describe '.deregister!' do
	  context 'when a valid id and token are passed in' do
	    let(:id) { Pipeline::Utility::PaperTrail.generate_papertrail_id('10.43.23.56') }
	    let(:token) { '2048hgr10grhsSHDfaheZ9' }
	    
      #       subject {
      #         Pipeline::Utility::PaperTrail.deregister!(id, token)
      #       }
      #       
      #       it { should_not be_nil }
      # it { should be_true }
    end
    
    context 'when an invalid id or token is passed in' do
      
    end
  end
end