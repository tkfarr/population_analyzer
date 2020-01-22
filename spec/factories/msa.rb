FactoryBot.define do
  factory :msa do
    cbsa
    mdiv { "92804" }
    name { "Los Angeles-Long Beach-Anaheim, CA" }
    lsad { "Metropolitan Statistical Area" }
    pop_estimate_2011 { 12952686 }
    pop_estimate_2012 { 13059779 }
    pop_estimate_2013 { 13165355 }
    pop_estimate_2014 { 13254397 }
    pop_estimate_2015 { 13340068 }
  end
end
