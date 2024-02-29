# In this file we define the methods to help filter out candidates
# This way, we keep these methods separated from other potential parts of the program

def find(id)
    @candidates.find { |candidate| candidate[:id] == id }
  end
  
  def experienced?(candidate)
    candidate[:years_of_experience] >= 2
  end
  
  def qualified_candidates(candidates)
    #adding each one by one via process of elimination.
    experienced_candidates = candidates.select { |candidate| experienced?(candidate) }
    github_points_candidates = experienced_candidates.select { |candidate| candidate[:github_points] >= 100 }
    ruby_or_python_candidates = github_points_candidates.select { |candidate| candidate[:languages].include?('Ruby') || candidate[:languages].include?('Python') }
    recent_applicants = ruby_or_python_candidates.select { |candidate| candidate[:date_applied] >= 15.days.ago.to_date }
    adult_candidates = recent_applicants.select { |candidate| candidate[:age] > 17 }

    adult_candidates
  end
  
  #return all candidates but list them via years of experience and again by github points.
  def ordered_by_qualifications(candidates)
    candidates.sort_by { |candidate| [-candidate[:years_of_experience], -candidate[:github_points]] }
  end