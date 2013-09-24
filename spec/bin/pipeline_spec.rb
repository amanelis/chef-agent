require 'bin/pipeline'


describe Pipeline::Utility::PaperTrail do
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
end