/*

From https://cseweb.ucsd.edu/~goguen/courses/130/SayBlackScholes.html
By Lou Odette, MA USA

*/

% black_scholes(+Type,+Spot,+Strike,+Expiry,+RiskFreeRate,+Volatily,-Price)

% call case
black_scholes(call,S,X,T,R,V,Price) :-
D1 is (ln(S/X) + (R+V*V/2)*T)/(V*sqrt(T)),
D2 is D1 - (V*sqrt(T)),
cumulative_normal(D1,CND1),
cumulative_normal(D2,CND2),
Price is S*CND1 - X*exp(-R*T)*CND2.

% put case
black_scholes(put,S,X,T,R,V,Price) :-
D1 is (ln(S/X) + (R+V*V/2)*T)/V*sqrt(T),
D2 is D1 - V*sqrt(T),
cumulative_normal(-D1,CND1),
cumulative_normal(-D2,CND2),
Price is X*exp(-R*T)*CND2 - S*CND1.

% Cumulative Normal Distribution
cumulative_normal(X,CND) :-
X < 0,
A1 is 0.31938153,
A2 is -0.356563782,
A3 is 1.781477937,
A4 is -1.821255978,
A5 is 1.330274429,
L is abs(X),
K is 1.0/(1.0 + (0.2316419 * L)),
CND is (1.0/sqrt(2*pi))*exp(-L*L/2)*(A1*K + A2*K*K + A3*(K^3) + A4*(K^4) + A5*(K^5)),!.

cumulative_normal(X,CND) :-
A1 is 0.31938153,
A2 is -0.356563782,
A3 is 1.781477937,
A4 is -1.821255978,
A5 is 1.330274429,
L is abs(X),
K is 1.0/(1.0 + (0.2316419 * L)),
CND is 1.0 - (1.0/(sqrt(2*pi))*exp(-L*L/2)*(A1*K + A2*K*K + A3*(K^3) + A4*(K^4) + A5*(K^5))).
